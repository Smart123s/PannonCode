namespace kiszh2
{

    public class Rootobject
    {
        public List<VenueDto> Venues { get; set; }
        public List<EventDto> Events { get; set; }
        public List<ParticipantDto> Participants { get; set; }
    }

    public class VenueDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
    }

    public class EventDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime Date { get; set; }
        public int VenueId { get; set; }
        public List<int> Participants { get; set; }
    }

    public class ParticipantDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

}
