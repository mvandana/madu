-- SQL Code
CREATE PROCEDURE usp_TrackCandidateProgress
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @progressReport NVARCHAR(MAX);
    SET @progressReport = N'<h2>Candidate Progress Report</h2><table border="1">
                            <tr>
                                <th>Candidate ID</th>
                                <th>Name</th>
                                <th>Licensure Status</th>
                                <th>Missing Requirements</th>
                            </tr>';

    -- Fetch candidates and their progress
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

    -- Close the HTML table
    SET @progressReport = @progressReport + N'</table>';

    -- Send the report to stakeholders
    EXEC usp_send_cte_mail 
        @source_proc = OBJECT_NAME(@@PROCID),
        @profile_name = 'CTE',
        @recipients = 'faculty@university.edu; admin@university.edu',
        @subject = 'Candidate Progress Report',
        @body = @progressReport,
        @body_format = 'HTML';

END;