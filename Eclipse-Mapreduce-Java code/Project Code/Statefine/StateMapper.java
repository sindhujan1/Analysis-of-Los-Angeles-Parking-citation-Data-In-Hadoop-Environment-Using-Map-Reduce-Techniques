import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.mapreduce.Mapper;

public class StateMapper extends Mapper<LongWritable, Text, Text, IntWritable>
{
	
            public void map(LongWritable key, Text value, Context context)
                    throws IOException, InterruptedException
                    {
                Text outputkey = new Text();
                IntWritable outputvalue = new IntWritable();
                String[] arrLine = value.toString().split(",");       
                String fine;
                String state;
                state=arrLine[2];
                fine=arrLine[9];
                outputvalue.set(Integer.parseInt(fine));
                outputkey.set(state);
                context.write(outputkey, outputvalue);
                
        }
}