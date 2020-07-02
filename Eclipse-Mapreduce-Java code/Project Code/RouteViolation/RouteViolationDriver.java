import java.io.IOException;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class RouteViolationDriver {


    public static void main(String[] args) throws Exception {
       
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
       
        conf.set("fs.defaultFS", "hdfs://localhost:54310");
        conf.set("fs.hdfs.impl", org.apache.hadoop.hdfs.DistributedFileSystem.class.getName() );
       

        Job job = new Job(conf, "Routeviolation");
       
        job.setJarByClass(RouteViolationDriver.class);
        job.setMapperClass(RouteViolationMapper.class);
        job.setReducerClass(RouteViolationReducer.class);  
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
       
        FileInputFormat.addInputPath(job, new Path("hdfs://localhost:54310/sqoop/part-m-00000"));
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/sqoop/bike/Monthvioroute"));

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}