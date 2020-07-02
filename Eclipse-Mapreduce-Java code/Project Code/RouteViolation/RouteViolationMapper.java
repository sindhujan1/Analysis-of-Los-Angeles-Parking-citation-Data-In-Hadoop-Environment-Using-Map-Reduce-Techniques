import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Mapper.Context;


public class RouteViolationMapper extends Mapper<LongWritable, Text, Text, IntWritable>
{
    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    @Override
    public void map(LongWritable key, Text value,
                    Mapper.Context context) throws IOException, InterruptedException
    {
        String[] line = value.toString().split(",");
       
        String Month,Vio,Route,Concat;
        Month= line[11];
        Vio=line[8];
        Route= line[6];
        Concat = Month + "," + Vio + "," + Route;
        word.set(Concat);
        context.write(word, one);
       
    }
}