using Newtonsoft.Json;

namespace DentalOffice.API.Events
{
    public abstract class BaseEvent
    {
        public string toJson() => JsonConvert.SerializeObject(this);
        public BaseEvent fromJson(string json) => JsonConvert.DeserializeObject<BaseEvent>(json);
    }
}
