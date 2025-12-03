using TicTacToe;

namespace TestProject1
{
    [TestClass]
    public sealed class Test1
    {

        // Írj unit tesztet, amely a GameBoard:: BoardReset (...) függvényt teszteli. Vizsgáld
        // meg, hogy a meghívása után minden mező megfelelően törlésre került-e!
        [TestMethod]
        public void TestMethod_Feladat1()
        {
            GameBoard gameBoard = new GameBoard();
            char[] board =
            {
                'O', 'X', 'X',
                'O', 'O', 'O',
                'O', 'X', 'X'
            };
            gameBoard.BoardReset(board);

            char[] emptyBoard =
            {
                '1', '2', '3',
                '4', '5', '6',
                '7', '8', '9'
            };

            Assert.AreEqual(board[0], emptyBoard[0]);
            Assert.AreEqual(board[1], emptyBoard[1]);
            Assert.AreEqual(board[2], emptyBoard[2]);
            Assert.AreEqual(board[3], emptyBoard[3]);
            Assert.AreEqual(board[4], emptyBoard[4]);
            Assert.AreEqual(board[5], emptyBoard[5]);
            Assert.AreEqual(board[6], emptyBoard[6]);
            Assert.AreEqual(board[7], emptyBoard[7]);
            Assert.AreEqual(board[8], emptyBoard[8]);

        }

        // Írj unit tesztet, amely a Player::SetSignature(...) függvényt teszteli, arra az esetre,
        // ha nem megfelelő inputot adunk meg.Ilyenkor InvalidDataException-t kell dobnia!

        [TestMethod]
        public void TestMethod_Feladat2()
        {
            Player player = new Player(1, 'X');
            char[] board =
            {
                '1', '2', '3',
                '4', '5', '6',
                '7', '8', '9'
            };
            Assert.Throws<InvalidDataException>(() => player.SetSignature(15, board));
        }

        // Írj egy base osztályt GameBoardTestBase néven, amely létrehozza és inicializálja
        // a GameBoard::CheckVerticalWin() függvény teszteléséhez szükséges változókat!

        public class GameBoardTestBase
        {
            protected GameBoard gameBoard;
            protected char[] boardWithVerticalWin;
            protected char[] boardWithoutWin;
            protected char[] boardDraw;
            protected char[] boardNotFinished;
            public GameBoardTestBase()
            {
                gameBoard = new GameBoard();
                boardWithVerticalWin = new char[]
                {
                    '1', 'O', '3',
                    '4', 'O', '6',
                    '7', 'O', '9'
                };
                boardWithoutWin = new char[]
                {
                    'X', 'O', 'X',
                    'O', 'X', 'O',
                    'O', 'X', 'O'
                };
                boardDraw = new char[]
                {
                    'X', 'O', 'X',
                    'O', 'X', 'O',
                    'O', 'X', 'O'
                };
                boardNotFinished = new char[]
                {
                    'X', 'O', '3',
                    '4', 'X', '6',
                    'O', '8', '9'
                };
            }
        }

        /* Írj unit tesztet, amely a GameBoard:: CheckVerticalWin (...) függvényt teszteli,
            amit a megvalósítás során a létrehozott base osztályból származtatunk, és azt
            vizsgálja, hogy a függvény megfelelő értékkel tér-e vissza, ha az egyik játékos a
            középső oszlopban nyerő pozícióban van! (4 pont)
            • Pl.: | 1 | O | 3 |
            ▪ | 4 | O | 6 |
            ▪ | 7 | O | 9 |
        */

        [TestClass]
        public sealed class Test3 : GameBoardTestBase
        {
            [TestMethod]
            public void TestMethod_Feladat3()
            {
                bool result = gameBoard.CheckVerticalWin(boardWithVerticalWin);
                Assert.IsTrue(result);
            }
        }


        /*  Írjunk unit tesztet, amely a GameBoard:: CheckDraw (...) függvényt teszteli. A
            megvalósítás során használjuk az előző feladat származtatott osztályt, valamint a
            tesztelendő felállást és az elvárt eredményt DataRow-ban határozzuk meg. A teszt
            képes legyen tesztelni a döntetlen és a még tovább játszható eseteket is.
        */

        [TestClass]
        public sealed class Test4 : GameBoardTestBase
        {
            [DataTestMethod]
            [DataRow(true)]
            [DataRow(false)]
            public void TestMethod_Feladat4(bool isDraw)
            {
                char[] board = isDraw ? boardDraw : boardNotFinished;
                bool result = gameBoard.CheckDraw(board);
                Assert.AreEqual(isDraw, result);
            }
        }
    }
}
