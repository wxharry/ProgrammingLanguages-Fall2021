/**
 * Server.java
 *
 * This creates the buffer and the producer and consumer threads.
 *
 */

public class Server
{
	public static class Opt{
		String name;
		public Opt(){this.name = "";}
		public String getName(){return this.name;}
		public void setName(String name){this.name = name;}
	}
	public static void main(String args[]) {
		Opt opt = new Opt();
		BoundedBuffer server1 = new BoundedBuffer();
		BoundedBuffer server2 = new BoundedBuffer();

      		// now create the producer and consumer threads

      		Producer producerAlice = new Producer(server1, opt, 6, "Alice");
      		Producer producerMoria = new Producer(server2, opt, 6, "Moira");
      		Consumer consumerJohnny = new Consumer(server1,server2, opt, 12, "Johnny");

      		producerAlice.start();
      		producerMoria.start();
      		consumerJohnny.start();

	}//main
}//class
