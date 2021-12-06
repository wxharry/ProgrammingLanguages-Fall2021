/**
 * Consumer.java
 *
 * This is the consumer thread for the bounded buffer problem.
 *
 */

import java.util.*;

public class Consumer extends Thread
{
   public Consumer(BoundedBuffer b1, BoundedBuffer b2, Server.Opt opt, int times, String name)
   {
	   
	  buffer1 = b1;
      buffer2 = b2;
      this.name = name;
      this.opt = opt;
      this.times = times;
   }

   public void run()
   {
   Integer message;
     while (times != 0)
      {
    	 synchronized(opt)
    	 {
    		 while(opt.getName() == "")
    		 {
    			 try {
					opt.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
    		 }
    		 if(opt.getName() == buffer1.getProducerName())
    		 {
    			message = (Integer)buffer1.remove();
                System.out.println("Consumer " + name + " consumed " + message + " produced by producer " + buffer1.getProducerName());
    		 }
    		 else
    		 {
                 message = (Integer)buffer2.remove();
                 System.out.println("Consumer " + name + " consumed " + message + " produced by producer " + buffer2.getProducerName());   			 
    		 }
    		 opt.setName("");
    		 opt.notifyAll();
    	 }
    	 --times;
      }	   
     System.out.println("Consumer " + name + " EXIT");
   }
   private  BoundedBuffer buffer1;
   private  BoundedBuffer buffer2;
   private  String name;
   private  Server.Opt opt;
   private  int times;

}


