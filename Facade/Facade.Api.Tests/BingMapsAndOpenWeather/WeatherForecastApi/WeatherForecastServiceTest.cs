using System;
using Facade.Logic;
using Facade.Logic.BingMapsAndOpenWeather.WeatherForecastApi;
using Xunit;

namespace Facade.Api.Tests.BingMapsAndOpenWeather.WeatherForecastApi
{
    public class WeatherForecastServiceTest
    {
        private readonly string? ApiKey = Environment.GetEnvironmentVariable("OPENWEATHER_APIKEY");

        [Fact]
        public void GetWeatherForecast__ReturnsWindForecast()
        {
            var dtOffset = new DateTimeOffset(DateTime.Now);
            var dt = dtOffset.ToUnixTimeSeconds();

            // https://www.latlong.net/convert-address-to-lat-long.html
            // Roermond NL
            var lat = 51.192699;
            var lon = 5.992880;

            var weatherForecastService = new WeatherForecastService();
            var forecast = weatherForecastService.GetWeatherForecast(lat, lon, ApiKey, "metric", "de");

            Assert.True(!double.IsNaN(forecast.daily[0].wind_speed));
        }

        [Fact]
        public void GetWeatherForecast_InvalidApiKey_ThrowsUnexpectedApiResponseException()
        {
            var weatherForecastService = new WeatherForecastService();
            Assert.Throws<UnexpectedApiResponseException>(() =>
                weatherForecastService.GetWeatherForecast(0.0, 0.0, "INVALID API KEY", "", ""));
        }
    }
}