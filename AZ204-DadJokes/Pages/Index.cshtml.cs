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
    public string Version { get; set; } = "v0.0.1";

    public async Task OnGet(CancellationToken cancellationToken)
    {
        Joke joke = await GetRandomJoke(cancellationToken);
        Joke = joke.Content;

        RunningEnvironment = Environment.GetEnvironmentVariable("RunningEnvironment");
        Version = Environment.GetEnvironmentVariable("VERSION") ?? "v0.0.1";
    }

    private async Task<Joke> GetRandomJoke(CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting the random Dad Joke");

        var httpClient = new HttpClient();
        httpClient.BaseAddress = new Uri("https://icanhazdadjoke.com/");

        var request = new HttpRequestMessage(HttpMethod.Get, "/");
        request.Headers.Add("Accept", "application/json");
        request.Headers.Add("User-Agent", "AZ204-DadJokes/v.0.0.1 (https://github.com/tomaszprasolek/AZ204-DadJokes)");

        HttpResponseMessage httpResponse = await httpClient.SendAsync(request, cancellationToken);
        var joke = await httpResponse.Content.ReadFromJsonAsync<Joke>(cancellationToken: cancellationToken);

        _logger.LogInformation("Dad joke: {Joke}", joke!.Content);
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