namespace kiszh2
{
    public class Event
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime Date { get; set; }
        public Venue Venue { get; set; } // Referencia a kapcsolódó Venue objektumra
        public List<Participant> Participants { get; set; } = new List<Participant>(); // Kapcsolódó résztvevők
    }
}
