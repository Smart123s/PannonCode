using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


/* Clear, update, display, check_for_win
 * check_for_draw
 * 
 */
namespace TicTacToe
{

    public class GameBoard
    {

        public GameBoard() { 
        
        
        }

        public void BoardReset(char[] ArrBoard) //If this method is called then the game resets.  
        {
            for(int i = 0; i < ArrBoard.Length; i++)
            {
                ArrBoard[i] = Convert.ToChar(49+i);
            }
            
        }

        public void DrawBoard(char[] ArrBoard)
        {
            Console.Clear();
            Console.WriteLine("  -------------------------");
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  |   {0}   |   {1}   |   {2}   |", ArrBoard[0], ArrBoard[1], ArrBoard[2]);
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  -------------------------");
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  |   {0}   |   {1}   |   {2}   |", ArrBoard[3], ArrBoard[4], ArrBoard[5]);
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  -------------------------");
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  |   {0}   |   {1}   |   {2}   |", ArrBoard[6], ArrBoard[7], ArrBoard[8]);
            Console.WriteLine("  |       |       |       |");
            Console.WriteLine("  -------------------------");
        } //Draws the player board to terminal.  

        public bool CheckWin(char[] ArrBoard)
        {
            if(CheckHorizontalWin(ArrBoard) ||
               CheckVerticalWin(ArrBoard)   ||
               CheckDiagonalWin(ArrBoard))
                return true;
            return false;
        }
        
        public bool CheckHorizontalWin(char[] ArrBoard)
        {
            char[] playerSignatures = { 'X', 'O' };

            foreach (char playerSignatue in playerSignatures)
            {
                if (   ((ArrBoard[0] == playerSignatue) && (ArrBoard[1] == playerSignatue) && (ArrBoard[2] == playerSignatue))
                    || ((ArrBoard[3] == playerSignatue) && (ArrBoard[4] == playerSignatue) && (ArrBoard[5] == playerSignatue))
                    || ((ArrBoard[3] == playerSignatue) && (ArrBoard[7] == playerSignatue) && (ArrBoard[8] == playerSignatue)))
                {
                    return true;
                }

            }
            return false;   
        } //Method is called to check for a horizontal win.  

        public bool CheckVerticalWin(char[] ArrBoard)
        {
            char[] playerSignatures = { 'X', 'O' };

            foreach (char playerSignatue in playerSignatures)
            {
                if (((ArrBoard[0] == playerSignatue) && (ArrBoard[3] == playerSignatue) && (ArrBoard[6] == playerSignatue))
                    || ((ArrBoard[1] == playerSignatue) && (ArrBoard[4] == playerSignatue) && (ArrBoard[7] == playerSignatue))
                    || ((ArrBoard[2] == playerSignatue) && (ArrBoard[5] == playerSignatue) && (ArrBoard[8] == playerSignatue)))
                {
                    
                    return true;
                }
            }
            return false;
        } //Method is called to check for a vertical win.  

        public bool CheckDiagonalWin(char[] ArrBoard)
        {
            char[] playerSignatures = { 'X', 'O' };

            foreach (char playerSignatue in playerSignatures)
            {
                if (((ArrBoard[0] == playerSignatue) && (ArrBoard[4] == playerSignatue) && (ArrBoard[8] == playerSignatue))
                    || ((ArrBoard[6] == playerSignatue) && (ArrBoard[4] == playerSignatue) && (ArrBoard[2] == playerSignatue)))
                {
                    return true;
                }
            }
            return false;
        } //Method is called to check for a diagonal win.

        public bool CheckDraw(char[] ArrBoard)
        {
            for( int i= 0; i<ArrBoard.Length-1; i++)
            {
                if (ArrBoard[i] != 'X' && ArrBoard[i] != 'O')
                    return false;
            }
            return true;

            
        } //Method is called to check if the game is a draw.
    }

}
