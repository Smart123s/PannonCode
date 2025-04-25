namespace halado_prog2

{


    using System;
    using System.IO;
    using System.Linq;
    public static class NeptunCodeLoader // Make it static if it only contains utility methods
    {
        /// <summary>
        /// Loads the Neptun code from the specified file path.
        /// Throws exceptions if the file is not found or is empty/invalid.
        /// </summary>
        /// <param name="filePath">The path to the file containing the Neptun code.</param>
        /// <returns>The trimmed Neptun code string.</returns>
        /// <exception cref="FileNotFoundException">Thrown if the file does not exist.</exception>
        /// <exception cref="InvalidOperationException">Thrown if the file is empty or reading fails.</exception>
        public static string LoadNeptunCodeFromFile(string filePath)
        {
            if (string.IsNullOrWhiteSpace(filePath))
            {
                throw new ArgumentException("File path cannot be null or empty.", nameof(filePath));
            }

            if (!File.Exists(filePath))
            {
                // As this is a required submission detail, file not found is a critical error
                throw new FileNotFoundException($"Neptun code file not found at: {filePath}");
            }

            try
            {
                // Read the first line from the file
                string fileContent = File.ReadAllLines(filePath).FirstOrDefault();

                if (string.IsNullOrWhiteSpace(fileContent))
                {
                    // File exists but is empty or contains only whitespace
                    throw new InvalidOperationException($"Neptun code file '{filePath}' is empty or contains only whitespace.");
                }

                string neptunCode = fileContent.Trim();

                // Optional: Add more specific validation on the format of neptunCode if needed
                // e.g., checking length or allowed characters

                Console.WriteLine($"Successfully loaded Neptun code '{neptunCode}' from {filePath}"); // Consider using a logger in a real app
                return neptunCode;
            }
            catch (IOException ioEx)
            {
                // Catch specific IO errors during file reading
                throw new InvalidOperationException($"IO error reading Neptun code from file '{filePath}': {ioEx.Message}", ioEx);
            }
            catch (Exception ex)
            {
                // Catch any other unexpected errors during reading
                throw new InvalidOperationException($"Unexpected error reading Neptun code from file '{filePath}': {ex.Message}", ex);
            }
        }

    }
}