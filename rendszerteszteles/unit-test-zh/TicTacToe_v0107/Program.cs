using TicTacToe;

class Program
{

    public static void Introduction()
    {
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine(".-----. _         .-----.             .-----.            ");
        Console.WriteLine("`-. .-':_;        `-. .-'             `-. .-'            ");
        Console.WriteLine("  : :  .-. .--.     : : .--.   .--.     : : .--.  .--.   ");
        Console.WriteLine("  : :  : :'  ..'    : :' .; ; '  ..'    : :' .; :' '_.'  ");
        Console.WriteLine("  :_;  :_;`.__.'    :_;`.__,_;`.__.'    :_;`.__.'`.__.'  ");
        Console.ResetColor();
        Console.WriteLine("\nWelcome to Tic Tac Toe, please press any to begin");
        Console.ReadKey();
        Console.Clear();
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine("RULES");
        Console.ResetColor();
        Console.WriteLine("Tic Tac Toe is a two player turn based game." +
                          "\nIt's you vs your opponent..." +
                          "\nPress any key to continue");
        Console.ReadKey();
        Console.Clear();
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine("RULES");
        Console.ResetColor();
        Console.WriteLine("Players are represented with a unique signature" +
                          "\nPlayer 1 = O.  Player 2 = X");
        Console.WriteLine("\nThe first player to score three signatures in a row is the winner" +
                          "\nGood luck players! \nNow press any key to begin...");
        Console.ReadKey();
    } //This method covers the game rules. Method setup in an effort to keep the code tidy.


    static void Main(string[] args)
    {
        Introduction();

        GameBoard Board = new GameBoard();
        char[] ArrBoard = new char[9];
        Board.BoardReset(ArrBoard);

         List<Player> players = new List<Player>()
        {
            new Player(1, 'X'),
            new Player(2, 'O')
        };
       
        int actual_player = 0; // Player 1 Starts
        int input = 0;

        do //Alternates player turns.
        {
            input = players[actual_player].Move(ArrBoard);
            players[actual_player].SetSignature(input, ArrBoard);

            Board.DrawBoard(ArrBoard);

            //Check Game Status.
            if (Board.CheckWin(ArrBoard))
            {
                Console.WriteLine("Congratulations Player {0} for Win.\n" +
                                  "You're the Tic Tac Toe Master!\n", actual_player+1);
                Console.ReadKey();
                break;
            }

            actual_player = ++actual_player % players.Count;

            if (Board.CheckDraw(ArrBoard))
            {
                Console.WriteLine("Aw gosh... it's a draw." +
                                  "\nPlease press any key to reset the game and try again!");
                Console.ReadKey();
                Board.BoardReset(ArrBoard);
                Board.DrawBoard(ArrBoard);
            }

        } while (true);

    } //Gameplay loop.  Controls player turns & overrides the array with players input.

}