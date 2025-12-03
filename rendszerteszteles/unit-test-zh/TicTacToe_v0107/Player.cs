using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace TicTacToe
{
    public class Player
    {
        public bool inputCorrect;
        
        public int id;

        public char playerSignature;
        public Player(int player_id, char player_signature) {
            id = player_id;
            playerSignature = player_signature;
        }

        public int Move(char[] ArrBoard)
        {
            int input = 0;
            do
            {
                Console.WriteLine("\nReady Player {0}: It's your move!", id);
                try
                {
                    input = Convert.ToInt32(Console.ReadLine());
                }
                catch
                {
                    Console.WriteLine("Please enter a number!");
                }

                if ((input == 1) && (ArrBoard[0] == '1'))
                    inputCorrect = true;
                else if ((input == 2) && (ArrBoard[1] == '2'))
                    inputCorrect = true;
                else if ((input == 3) && (ArrBoard[2] == '3'))
                    inputCorrect = true;
                else if ((input == 4) && (ArrBoard[3] == '4'))
                    inputCorrect = true;
                else if ((input == 5) && (ArrBoard[4] == '5'))
                    inputCorrect = true;
                else if ((input == 6) && (ArrBoard[5] == '6'))
                    inputCorrect = true;
                else if ((input == 7) && (ArrBoard[6] == '7'))
                    inputCorrect = true;
                else if ((input == 8) && (ArrBoard[7] == '8'))
                    inputCorrect = true;
                else if ((input == 9) && (ArrBoard[8] == '9'))
                    inputCorrect = true;
                else
                {
                    Console.WriteLine("Whoops, I didn't get that.  \nPlease try again...");
                    inputCorrect = false;
                }


            } while (!inputCorrect);

            return input;
        }


        public void SetSignature(int input, char[] ArrBoard)
        {
            if (input < 1 || input > 10)
            {
                throw new InvalidDataException();
            }

            switch (input)
            {
                case 1: ArrBoard[0] = playerSignature; break;
                case 2: ArrBoard[1] = playerSignature; break;
                case 3: ArrBoard[2] = playerSignature; break;
                case 4: ArrBoard[3] = playerSignature; break;
                case 5: ArrBoard[4] = playerSignature; break;
                case 6: ArrBoard[5] = playerSignature; break;
                case 7: ArrBoard[6] = playerSignature; break;
                case 8: ArrBoard[7] = playerSignature; break;
                case 9: ArrBoard[8] = playerSignature; break;
            }

        } //Controls if the player is X or O.

    }
}
