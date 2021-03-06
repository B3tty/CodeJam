﻿using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace IOError
{
    class Program
    {
        private static readonly string small_input_name = @"A-small-practice.in";
        private static readonly string small_output_name = @"A-small-practice.out";
        private static readonly string large_input_name = @"A-large-practice.in";
        private static readonly string large_output_name = @"A-large-practice.out";

        private static readonly string _casesSeparator = "\n";
        private static readonly int _nbArgs = 2;
        private static readonly string _itemsSeparator = " ";

        static void Main(string[] args)
        {
            HandleFile(small_input_name, small_output_name);
            //HandleFile(large_input_name, large_output_name);
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
            var c = int.Parse(kase[0]);

            var items = kase[1].Split(_itemsSeparator);

            return $"Case #{index + 1}: {string.Join(" ", kase)}";
        }
    }
}
