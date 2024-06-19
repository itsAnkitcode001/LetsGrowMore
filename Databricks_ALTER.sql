
-- Drop Constraint, Rename and Create Table SQL

DROP TABLE IF EXISTS Test

;
CREATE TABLE gstest.tbl_Students
(
    StudentId int  NOT NULL,
    Firstname string,
    Lastname string  NOT NULL,
    Email string  NOT NULL,
    DOB date  NOT NULL,
    AverageScore int  COMMENT 'The average test score is a measure that indicates how a student performed on a test compared to a representative sample of students of the same age from the general population. Here are some key points about average test scores:
Standard Scores: Most educational and psychological tests provide standard scores based on a scale with a statistical mean (or average score) of 100. If a student earns a standard score below 100, they performed below the mean, while a score above 100 indicates performance above the mean. The majority of test scores fall between one standard deviation below and one standard deviation above 100, which corresponds to a range of 85 to 115.
Classification Categories:
Low Average: Standard scores of 80-89
Average: Standard scores of 90-109
High Average: Standard scores of 110-119.
Subtest Scores: Many psychological tests consist of multiple subtests, each measuring specific abilities. These subtest scores are combined into a composite or index score with a mean of 100. For example, subtest scores for vocabulary, comprehension, and general information may form a broad verbal comprehension index.
Remember that average test scores provide valuable insights into a student’s performance relative to their peers. Understanding these scores helps educators and parents make informed decisions about educational support and interventions
',
    Address array <struct<
        Country	string NOT NULL,
        City	string NOT NULL,
        CAP	int NOT NULL
    >>
)

;

-- Add Constraint SQL


ALTER TABLE gstest.tbl_Students
    ADD CONSTRAINT pk1 PRIMARY KEY (StudentId) 

;

-- Add Comments SQL


COMMENT ON TABLE gstest.tbl_Students IS 'A student is an individual who is actively engaged in learning, typically within an educational institution such as a school or university. Students are enrolled in courses or programs through which they acquire knowledge, skills, and competencies related to various subjects or disciplines. They can be undergraduates, postgraduates, or individuals studying to enter a specific profession. Whether it’s a law, philosophy, or medical student, their pursuit of education shapes their understanding of the world. In schools, teachers use a variety of materials to inspire their students, fostering a love for learning. As a nurse, one becomes a student of human nature, delving into the intricacies of the human experience. So, whether you’re a kindergartener or a graduate student, the journey of learning continues, and each student contributes to the collective pursuit of knowledge.
'

;
