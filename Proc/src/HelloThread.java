public class HelloThread implements Runnable
{
	public void run()
	{
		System.out.println("Hello from a thread!");
	}

	public static void main(String args[])
	{
		System.out.println("About to create a thread");
		Thread thread = new Thread(new HelloThread());
		thread.start();

		try
		{
			thread.join();
		}
		catch (InterruptedException e)
		{
			System.err.println("Error in joining thread");
			return;
		}
		System.out.println("Thread finished");
	}
} 
