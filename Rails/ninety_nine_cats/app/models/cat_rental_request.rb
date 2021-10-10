class CatRentalRequest < ApplicationRecord
    validates :start_date, :end_date, :cat_id, :status, presence: true 
    validates :status, inclusion: {in: %w(DENIED APPROVED PENDING)}
    validate :does_not_overlap_approved_request

    belongs_to :cat
    belongs_to :requester, 
        foreign_key: :requester_id,
        class_name: 'User'
        
    def denied?
        self.status == 'DENIED'
    end

    def pending?
        self.status == 'PENDING'
    end

    def overlapping_pending_requests 
        overlapping_requests.where(status: 'PENDING')
    end

    def approve!
        raise "not pending" unless status == 'PENDING'
        ActiveRecord::Base.transaction do 
            self.status = 'APPROVED'      # Writing "status = 'APPROVED'" does not work: https://stackoverflow.com/questions/22032801/whats-the-difference-between-using-self-attribute-and-attribute-in-a-model
            self.save! 
            overlapping_pending_requests.each do |req| 
                req.deny!
            end
        end
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    private
    # We want:
    # 1. A different request
    # 2. That is for the same cat.
    # 3. That overlaps.
    def overlapping_requests
        CatRentalRequest
            .where(cat_id: self.cat_id)
            .where.not("end_date < ? OR start_date > ?", self.start_date, self.end_date)
            .where.not(id: self.id)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def does_not_overlap_approved_request
        # A denied request doesn't need to be checked. A pending request
        # should be checked; users can not make requests when cat is already rented
        return if self.denied?
        if overlapping_approved_requests.count > 0
            errors[:base] << "Request conflicts with already approved request"
        end
    end
end