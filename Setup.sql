-- Create Database
CREATE DATABASE TestCoTE;
USE TestCoTE;

-- Create Tables
CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    name NVARCHAR(100),
    program_id INT
);

CREATE TABLE licensure_requirements (
    requirement_id INT PRIMARY KEY,
    program_id INT,
    name NVARCHAR(100)
);

CREATE TABLE candidate_requirements (
    candidate_id INT,
    requirement_id INT,
    completed BIT,
    PRIMARY KEY (candidate_id, requirement_id)
);

-- Insert Sample Data
INSERT INTO candidates VALUES (1, 'John Doe', 101);
INSERT INTO candidates VALUES (2, 'Jane Smith', 101);

INSERT INTO licensure_requirements VALUES (1, 101, 'Requirement A');
INSERT INTO licensure_requirements VALUES (2, 101, 'Requirement B');

INSERT INTO candidate_requirements VALUES (1, 1, 1); -- John completed Requirement A
INSERT INTO candidate_requirements VALUES (2, 1, 1); -- Jane completed Requirement A

-- Deploy Stored Procedure
CREATE PROCEDURE usp_TrackCandidateProgress
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @progressReport NVARCHAR(MAX);
    SET @progressReport = N'<h2>Candidate Progress Report</h2><table border="1">
                            <tr>
                                <th>Candidate ID</th>
                                <th>Name</th>
                                <th>Licensure Status</th>
                                <th>Missing Requirements</th>
                            </tr>';

    INSERT INTO @progressReport
    SELECT 
        CONCAT('<tr><td>', candidate_id, '</td><td>', candidate_name, '</td><td>',
               CASE 
                   WHEN completed_requirements = total_requirements THEN 'Complete'
                   ELSE 'Incomplete'
               END, '</td><td>',
               CASE 
                   WHEN completed_requirements < total_requirements THEN STRING_AGG(requirement_name, ', ')
                   ELSE 'None'
               END, '</td></tr>')
    FROM 
        (
            SELECT 
                c.candidate_id,
                c.name AS candidate_name,
                COUNT(DISTINCT r.requirement_id) AS total_requirements,
                COUNT(DISTINCT cr.requirement_id) AS completed_requirements,
                STRING_AGG(r.name, ', ') AS requirement_name
            FROM 
                candidates c
            LEFT JOIN 
                licensure_requirements r ON c.program_id = r.program_id
            LEFT JOIN 
                candidate_requirements cr ON c.candidate_id = cr.candidate_id AND cr.completed = 1
            GROUP BY 
                c.candidate_id, c.name
        ) progress;

    SET @progressReport = @progressReport + N'</table>';

    PRINT @progressReport;
END;