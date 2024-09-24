using KisZH1Parctice;
using System;
using System.Text.Json;

internal interface ITestResultManager
{
    void LoadData(string filePath);
}

internal class TestResultManager : ITestResultManager
{
    private List<TestResult> _testResults = new List<TestResult>();
    private Dictionary<string, List<TestResult>> _byGroup = new Dictionary<string, List<TestResult>>();

    public void LoadData(string filePath)
    {
        var content = File.ReadAllText(filePath);
        var result = JsonSerializer.Deserialize<List<TestResult>>(content);
        _testResults.AddRange(result);

        /*
        foreach (var testResult in result)
        {
            // ez egy pici performance hit a try catch miatt
            try
            {
                _byGroup[testResult.Group].Add(testResult);
            } catch (KeyNotFoundException e)
            {
                _byGroup[testResult.Group] = new List<TestResult>([testResult]);
            }
            
        }
        */
        _byGroup = result.GroupBy(tr => tr.Group)
                            .ToDictionary(g => g.Key, g => g.ToList());

    }

    public TestResult FindScore(int score, int minute)
    {
        TestResult? res = _testResults.Find(a => a.Score >= score && a.WorkTime < minute);
        if (res == null )
        {
            throw new ArgumentException();
        }
        return res;

    }

    public void PrintAverages()
    {
        foreach (var item in _byGroup) {
            Console.WriteLine("Average of group " + item.Key + ": " + item.Value.Average(a => a.Score));
        }
    }
}
