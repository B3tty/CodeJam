using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Zarathras
{
    class Program
    {
        private static readonly string small_input_name = @"B-small-practice.in";
        private static readonly string small_output_name = @"B-small-practice.out";
        private static readonly string large_input_name = @"B-large-practice.in";
        private static readonly string large_output_name = @"B-large-practice.out";

        private static readonly string _casesSeparator = "\n";
        private static readonly int _nbArgs = 1;
        private static readonly string _itemsSeparator = " ";

        static void Main(string[] args)
        {
            //HandleFile(small_input_name, small_output_name);
            HandleFile(large_input_name, large_output_name);
        }

        private static void HandleFile (string inputPath, string outputPath)
        {
            var rawCases = ReadInput(inputPath);
            var nbCases = GetNbOfCases(rawCases);
            var cases = SplitInputs(rawCases, nbCases);

            using (var file =
                new StreamWriter(File.Open(GetResultFilePath(outputPath), FileMode.Create)))
            {
                var index = 0;
                foreach (List<string> kase in cases)
                {
                    Console.WriteLine($"Case {index}");
                    file.Write($"{RunCase(kase, index)}\n");
                    index++;
                }
            }

        }

        private static List<string> ReadInput(string filePath)
        {
            string inputString = File.ReadAllText(filePath);
            var rawCases = inputString.Split(_casesSeparator).ToList();
            return rawCases;
        }

        private static int GetNbOfCases(List<string> rawCases)
        {
            return int.Parse(rawCases[0]);
        }

        private static List<List<string>> SplitInputs(List<string> rawCases, int nbCases)
        {
            var cases = Enumerable.Range(0, nbCases).Select(i =>
                rawCases.GetRange(i * _nbArgs + 1, _nbArgs)
            );
            return cases.ToList();
        }

        private static string GetResultFilePath(string outputPath)
        {
            return string.Concat(@"D:\Github\Betty\CodeJam\CodeJamWomen\C#\", typeof(Program).Namespace, "\\", outputPath);
        }


        private static string RunCase(List<string> kase, int index)
        {
            var items = kase[0].Split(_itemsSeparator);
            double A = int.Parse(items[0]);
            double B = int.Parse(items[1]);
            var alpha = int.Parse(items[2]);
            var beta = int.Parse(items[3]);
            double Y = double.Parse(items[4]);

            foreach(int year in Enumerable.Range(0, int.MaxValue))
            {
                if (year >= Y)
                {
                    break;
                }
                var newPop = OneYear(A, B, alpha, beta);
                var newA = newPop[0];
                var newB = newPop[1];
                if (A == newA && B == newB)
                {
                    break;
                }
                A = newA;
                B = newB;
            }


            return $"Case #{index + 1}: {A} {B}";
        }

        private static double[] OneYear(double A, double B, int alpha, int beta)
        {
            // calculate couples
            var couples = GetCouples(A, B);

            // calculate babies
            var babies = ProducedBabies(couples);

            // calculate A & B babies
            var classedBabies = RepartitionBabies(babies, alpha, beta);
            var aBabies = classedBabies[0];
            var bBabies = classedBabies[1];

            // decomission
            var classedDecom = Decommission(A, B);
            var aDeco = classedDecom[0];
            var bDeco = classedDecom[1];

            // new numbers

            var newA = A + aBabies - aDeco;
            var newB = B + bBabies - bDeco;

            double[] result = { newA, newB };

            return result;
        }

        private static double GetCouples(double A, double B)
        {
            return Math.Min(A, B);
        }

        private static double ProducedBabies(double couples)
        {
            return Math.Floor(couples * 0.02);
        }

        private static double[] RepartitionBabies(double babies, int alpha, int beta)
        {
            var aBabies = Math.Floor(babies * alpha / 100);
            var bBabies = Math.Floor(babies * beta / 100);

            var remainingBabies = babies - aBabies - bBabies;

            aBabies += Math.Floor(remainingBabies / 2);
            bBabies += remainingBabies - Math.Floor(remainingBabies / 2);

            double[] resultBabies = { aBabies, bBabies };

            return resultBabies;
        }

        private static double[] Decommission(double A, double B)
        {
            var aDecommision = Math.Floor(A * 0.01);
            var bDecommission = Math.Floor(B * 0.01);

            double[] result = { aDecommision, bDecommission };

            return result;
        }



    }
}
