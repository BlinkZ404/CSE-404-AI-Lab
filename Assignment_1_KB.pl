/* University Course Prerequisite & Scheduling System in Prolog */

/* Facts: Courses with course code and credits */
course(cse101, 3.0).   course(phy101, 3.0).   course(mth101, 3.0).
course(cse102, 1.5).   course(hss101, 3.0).   course(hss111a, 2.0).
course(hss111b, 2.0).  course(phy102, 1.5).   course(cse103, 3.0).
course(cse104, 1.5).   course(cse105, 3.0).   course(eee121, 3.0).
course(eee122, 1.5).   course(mth103, 3.0).   course(chem111, 3.0).
course(chem112, 1.5).  course(cse203, 3.0).   course(cse204, 1.5).
course(cse205, 3.0).   course(cse206, 1.5).   course(mth201, 3.0).
course(eee221, 4.0).   course(eee222, 1.5).   course(mth203, 3.0).
course(cse207, 3.0).   course(cse208, 1.5).   course(cse209, 4.0).
course(cse210, 1.5).   course(cse211, 3.0).   course(cse212, 1.5).
course(mth205, 3.0).   course(ecn201, 2.0).   course(cse303, 3.0).
course(cse304, 0.75).  course(cse305, 3.0).   course(cse306, 0.75).
course(cse307, 3.0).   course(cse309, 3.0).   course(cse310, 1.5).
course(cse311, 3.0).   course(cse312, 1.5).   course(hss301, 2.0).
course(cse317, 3.0).   course(cse319, 3.0).   course(cse320, 1.5).
course(cse321, 3.0).   course(cse322, 0.75).  course(cse330, 1.5).
course(cse313, 3.0).   course(cse314, 0.75).  course(cse315, 3.0).
course(cse316, 1.5).   course(cse401, 3.0).   course(cse403, 3.0).
course(cse404, 1.5).   course(cse405, 3.0).   course(cse406, 1.5).
course(cse407, 2.0).   course(cse410, 1.5).   course(cse427, 3.0).
course(cse400, 3.0).   course(cse425, 3.0).   course(cse426, 1.5).
course(cse429, 3.0).   course(cse430, 1.5).   course(bus401, 3.0).
course(bus402, 0.75).

/* Facts: Course Prerequisites */
prerequisite(cse103, cse101).  prerequisite(cse205, cse101).
prerequisite(cse203, cse103).  prerequisite(cse205, cse103).
prerequisite(cse205, cse105).  prerequisite(cse207, cse103).
prerequisite(cse207, cse205).  prerequisite(mth201, mth103).
prerequisite(mth201, mth101).  prerequisite(mth205, mth201).
prerequisite(cse303, ecn201).  prerequisite(cse303, phy101).
prerequisite(cse303, mth205).  prerequisite(cse305, cse211).
prerequisite(cse306, cse212).  prerequisite(cse307, cse207).
prerequisite(cse309, cse203).  prerequisite(cse309, cse211).
prerequisite(cse317, cse209).  prerequisite(cse319, cse303).
prerequisite(cse321, cse305).  prerequisite(cse322, cse306).
prerequisite(cse405, cse207).  prerequisite(cse405, cse317).
prerequisite(cse410, cse321).

/* Facts: Student Course Completion Records */
completed(arif, cse101).   completed(arif, phy101).
completed(sami, cse101).   completed(sami, cse103).
completed(arafat, cse101). completed(arafat, cse205).
completed(abir, cse311).   completed(abir, cse312).

/* Query: Courses that have no prerequisites */
no_prereq_course(Course) :-
    course(Course, _),
    \+ prerequisite(Course, _).

/* Query: Check if a student has completed a specific course */
has_completed(Student, Course) :-
    completed(Student, Course).

/* Query: Check if a student is eligible for a course by verifying at least one prerequisite */
eligible(Student, Course) :-
    prerequisite(Course, Prereq),
    completed(Student, Prereq).

/* Query: List all courses a student can potentially take next (not yet completed) */
next_possible_course(Student, Course) :-
    prerequisite(Course, Prereq),
    completed(Student, Prereq),
    \+ completed(Student, Course).

/* Recursive Query: Retrieve all prerequisite chains for a course */
prereq_chain(Course, Prereq) :-
    prerequisite(Course, Prereq).
prereq_chain(Course, Indirect) :-
    prerequisite(Course, Intermediate),
    prereq_chain(Intermediate, Indirect).

/* Query: Sum the total credits of courses a student has completed */
credits_completed(Student, TotalCredits) :-
    findall(Credit, (completed(Student, C), course(C, Credit)), Credits),
    sumlist(Credits, TotalCredits).

/* Query: Sum the credits of the entire program */
program_total_credits(Total) :-
    findall(Credit, course(_, Credit), Credits),
    sumlist(Credits, Total).
