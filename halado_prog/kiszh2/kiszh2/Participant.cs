namespace kiszh2
{
    public class Participant
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<Event> Events { get; set; } = new List<Event>(); // Kapcsolódó események
    }
}
