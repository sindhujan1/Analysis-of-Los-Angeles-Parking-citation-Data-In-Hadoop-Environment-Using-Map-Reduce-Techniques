bike = LOAD 'hdfs://localhost:54310/sqoop/part-m-00000' USING PigStorage(',') AS (TicketID:int,IssueDate:chararray,StatePlate:chararray,Make:chararray,BodyStyle:chararray,Colour:chararray,Route:chararray,Agency:INT,Violation:chararray,Fine:int,Year:int,Month:int,Day:int);

H = FILTER bike BY Year == 2018;
R = GROUP H BY Make;	
T = FOREACH R GENERATE group, COUNT(H.Make);
STORE T INTO 'hdfs://localhost:54310/Pig_Output/MakeCount';

Y = GROUP H BY Colour;	
U = FOREACH Y GENERATE group, COUNT(H.Colour);
STORE U INTO 'hdfs://localhost:54310/Pig_Output/ColourCount';

J = GROUP H BY BodyStyle;
K = FOREACH J GENERATE group, COUNT(H.BodyStyle);
STORE K INTO 'hdfs://localhost:54310/Pig_Output/Bodystylecount';

V = GROUP H BY Route;
X = FOREACH V GENERATE group, COUNT(H.Route);
STORE X INTO 'hdfs://localhost:54310/Pig_Output/Routecount';


