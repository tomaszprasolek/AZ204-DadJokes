using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.CodeAnalysis;
using System.Text.Json.Serialization;

namespace AZ204_DadJokes.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }

    public string Joke { get; set; } = string.Empty;
    public string? RunningEnvironment { get; set; }

    public async Task OnGet(CancellationToken cancellationToken)
    {
        Joke joke = await GetRandomJoke(cancellationToken);
        Joke = joke.Content;

        RunningEnvironment = Environment.GetEnvironmentVariable("RunningEnvironment");
    }

    private static async Task<Joke> GetRandomJoke(CancellationToken cancellationToken)
    {
        var httpClient = new HttpClient();
        httpClient.BaseAddress = new Uri("https://icanhazdadjoke.com/");

        var request = new HttpRequestMessage(HttpMethod.Get, "/");
        request.Headers.Add("Accept", "application/json");
        request.Headers.Add("User-Agent", "https://github.com/tomaszprasolek/AZ204-DadJokes");

        HttpResponseMessage httpResponse = await httpClient.SendAsync(request, cancellationToken);
        var joke = await httpResponse.Content.ReadFromJsonAsync<Joke>(cancellationToken: cancellationToken);
        return joke!;
    }
}

[SuppressMessage("ReSharper", "UnusedMember.Global")]
public sealed class Joke
{
    public string Id { get; set; }

    [JsonPropertyName("joke")] public string Content { get; set; }

    public int Status { get; set; }
}