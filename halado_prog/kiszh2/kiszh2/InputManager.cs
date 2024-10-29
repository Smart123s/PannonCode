using System.Text.Json;

namespace kiszh2
{
    public class InputManager
    {
        public List<Venue> Venues;
        public List<Event> Events;
        public List<Participant> Participants;

        public InputManager(string inputFileName)
        {
            Venues = new List<Venue>();
            Events = new List<Event>();
            Participants = new List<Participant>();
            Load(inputFileName);
        }

        private void Load(string inputFileName)
        {
            string json = File.ReadAllText("events.json");
            var serializerSettings = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };
            var inputData = JsonSerializer.Deserialize<Rootobject>(json, serializerSettings);

            inputData.Venues.ForEach(venue =>
            {
                var item = new Venue
                {
                    Id = venue.Id,
                    Name = venue.Name,
                    Location = venue.Location,
                };
                Venues.Add(item);
            });

            inputData.Participants.ForEach(participant =>
            {
                var item = new Participant
                {
                    Id = participant.Id,
                    Name = participant.Name,
                    Events = new List<Event>()
                };
                Participants.Add(item);
            });

            inputData.Events.ForEach(eventData =>
            {
                var item = new Event
                {
                    Id = eventData.Id,
                    Name = eventData.Name,
                    Date = eventData.Date,
                    Venue = Venues.FirstOrDefault(item => item.Id == eventData.VenueId) ?? new Venue()
                };

                var participants = Participants.Where(item => eventData.Participants.Contains(item.Id)).ToList();
                item.Participants = participants;
                participants.ForEach(participant =>
                {
                    participant.Events.Add(item);
                });
                Events.Add(item);
            });
        }

        public Event MostPopular()
        {
            return this.Events.OrderBy(a => -a.Participants.Count).ToList()[0];
        }

        public List<Participant> MoreThan8()
        {
            return Participants.FindAll(a => a.Events.Count >= 8);
        }

        public Dictionary<Venue, double> AverageEventCount()
        {
            Dictionary<Venue, List<Event>>  dict = Events.GroupBy(a => a.Venue)
                .ToDictionary(g => g.Key, g => g.ToList());

            Dictionary<Venue, double> avgs = new Dictionary<Venue, double>();
            foreach (var item in dict)
            {
                avgs[item.Key] = item.Value.Average(a => a.Participants.Count);
            }

            return avgs.OrderBy(a => -a.Value).ToDictionary();
            
        }
    }
}
