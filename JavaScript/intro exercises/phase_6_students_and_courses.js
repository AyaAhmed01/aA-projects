function Student(fname, lname){
    this.fname = fname;
    this.lname = lname;
    this.courses = [];
}

Student.prototype.name = function(){ return '${this.fname} ${this.lname}'};

Student.prototype.enroll = function(course){
    if(!this.courses.includes(course)){
        if(this.hasConflict(course))
            throw "Makes conflict!"
        this.courses.push(course); 
        course.addStudent(this);
    }
}

Student.prototype.hasConflict = function (course){
    return this.courses.some(curCourse => curCourse.conflictsWith(course))
};

Student.prototype.courseLoad = function (){
    load = {};
    this.courses.forEach((course) => {
        load[course.dep] = load[course.dep] || 0;  // the initial value is undefined NOT 0
        load[course.dep] += course.numOfCredits;
    })
    return load;
};  // department: #of credits the student has

function Course(name, dep, numOfCredits, days, block){
    this.name = name;
    this.dep = dep;
    this.numOfCredits = numOfCredits;
    this.students = [];
    this.days = days;
    this.blocks = block;  // the block that the course takes up in each day
}

Course.prototype.addStudent = function(s){
    if(!this.students.includes(s)){
        s.enroll(this);
        this.students.push(s);
    }
};

Course.prototype.conflictsWith = function (other) {
    if(this.block !== other.block) { return false; }
    return this.days.some(day => other.days.indexOf(day) !== -1);
};


//Comment in the code below to run

let student1 = new Student("Nigel", "Leffler");
let course1 = new Course("101", "CS", 3, ["mon", "wed", "fri"], 1);
let course2 = new Course("201", "CS", 3, ["wed"], 1);
let course3 = new Course("301", "ENG", 3, ["tue"], 1);
let course4 = new Course("401", "BIO", 3, ["mon", "wed", "fri"], 2);
console.log(student1.name());
student1.enroll(course1);
student1.enroll(course3);
student1.enroll(course2);
console.log(student1.courseLoad());
console.log('should be true = ' + course1.conflictsWith(course2));
console.log('should be false = ' + course1.conflictsWith(course3));
console.log('should be false = ' + course1.conflictsWith(course4));
