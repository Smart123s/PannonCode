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

    public Dictionary<string, float> GetAveragesByGroup()
    {
        Dictionary<string, float> averages = new Dictionary<string, float>();
        foreach (var item in _byGroup) {
            averages[item.Key] = (float) item.Value.Average(a => a.Score);
        }
        averages = averages.OrderBy(a => -a.Value).ToDictionary(a => a.Key, a => a.Value);
        return averages;
    }

    public Dictionary<string, Dictionary<int, int>> GetGrades()
    {
        Dictionary<string, Dictionary<int, int>> grades = new Dictionary<string, Dictionary<int, int>>();
        foreach (var item in _byGroup)
        {
            grades[item.Key] = new Dictionary<int, int>();
            grades[item.Key][1] = item.Value.Count(a => a.Score <= 59);
            grades[item.Key][2] = item.Value.Count(a => a.Score >= 60 && a.Score <= 69);
            grades[item.Key][3] = item.Value.Count(a => a.Score >= 70 && a.Score <= 79);
            grades[item.Key][4] = item.Value.Count(a => a.Score >= 80 && a.Score <= 89);
            grades[item.Key][5] = item.Value.Count(a => a.Score >= 90 && a.Score <= 100);
            grades[item.Key] = grades[item.Key].OrderBy(a => -a.Value).ToDictionary(a => a.Key, a => a.Value);
        }
        return grades;
    }
}
