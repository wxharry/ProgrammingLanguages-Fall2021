/**
 * Producer.java
 *
 * This is the producer thread for the bounded buffer problem.
 *
 */

import java.util.*;

public class Producer extends Thread
{
   public Producer(BoundedBuffer b, Server.Opt opt, int n, String name) {
      buffer = b;
      b.setProducerName(name);
      times = n;
      this.name = name;
      this.opt = opt;
   }

   public void run()
   {
   Integer  message;
   
   	  while(times!=0)
      {
         int sleeptime = (int) (BoundedBuffer.NAP_TIME * Math.random()) +1;

         System.out.println("Producer " + name +" sleeping for " + sleeptime + " seconds");

         try { sleep(sleeptime*1000); }
         catch(InterruptedException e) {}

         // produce an item & enter it into the buffer
         message = Integer.valueOf((int)(Math.random()*(max-min+1)+min));
         System.out.println("Producer " + name + " produced " + message);

         buffer.enter(message);
         synchronized(opt){
        	 while(opt.getName() != "")
        	 {
        		try {
					opt.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
        	 }
        	 opt.setName(name);
        	 opt.notify();
         }
         --times;
      }
   	  System.out.println("Producer " + name + " EXIT");
   }
   
   
   
   public int getTimes() {
	return times;
}

public void setTimes(int times) {
	this.times = times;
}



private  BoundedBuffer buffer;
   private  int times;
   private  String name;
   private  double max = 60000;
   private  double min = 4000;
   private Server.Opt opt; 

}
