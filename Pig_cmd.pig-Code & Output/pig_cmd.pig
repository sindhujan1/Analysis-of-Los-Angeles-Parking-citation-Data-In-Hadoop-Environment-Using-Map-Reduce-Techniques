bike = LOAD 'hdfs://localhost:54310/sqoop/part-m-00000' USING PigStorage(',') AS (TicketID:int,IssueDate:chararray,StatePlate:chararray,Make:chararray,BodyStyle:chararray,Colour:chararray,Route:chararray,Agency:INT,Violation:chararray,Fine:int,Year:int,Month:int,Day:int);

A = GROUP bike BY Year;	
B = FOREACH A GENERATE group, AVG(bike.Fine);
STORE B INTO 'hdfs://localhost:54310/Pig_Output/AvgYearfine';

C = GROUP bike BY Month;
D = FOREACH C GENERATE group, AVG(bike.Fine);
STORE D INTO 'hdfs://localhost:54310/Pig_Output/AvgMonthfine';

E = GROUP bike BY Day;
F = FOREACH E GENERATE group, AVG(bike.Fine);
STORE F INTO 'hdfs://localhost:54310/Pig_Output/AvgDayfine';


