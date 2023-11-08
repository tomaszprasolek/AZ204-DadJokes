using Microsoft.AspNetCore.Mvc.RazorPages;
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

    public async Task OnGet(CancellationToken cancellationToken)
    {
        var httpClient = new HttpClient();
        httpClient.BaseAddress = new Uri("https://icanhazdadjoke.com/");
        
        var request = new HttpRequestMessage(HttpMethod.Get, "/");
        request.Headers.Add("Accept", "application/json");
        
        HttpResponseMessage httpResponse = await httpClient.SendAsync(request, cancellationToken);
        var joke = await httpResponse.Content.ReadFromJsonAsync<Joke>(cancellationToken: cancellationToken);

        Joke = joke.Content;
    }
}

public sealed class Joke
{
    public string Id { get; set; }

    [JsonPropertyName("joke")] 
    public string Content { get; set; }

    public int Status { get; set; }
}