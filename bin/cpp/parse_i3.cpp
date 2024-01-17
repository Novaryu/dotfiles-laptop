#include <iostream>
#include <string>
#include <vector>
#include "json.hpp"

using json = nlohmann::json;

int main(int argc, char* argv[]) {
    // Check if a JSON string is provided as a command-line argument
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <json_data>" << std::endl;
        return 1;  // Exit with an error code
    }

    // Parse JSON
    std::string jsonString(argv[1]);
    json parsedData;

    try {
        parsedData = json::parse(jsonString);
    } catch (const std::exception& e) {
        std::cerr << "Error parsing JSON: " << e.what() << std::endl;
        return 1;  // Exit with an error code
    }

    // Build a string containing all window names
    std::string outputString;

    for (const auto& workspace : parsedData) {
        std::string windowName = workspace["name"];
        bool isFocused = workspace["focused"];

        if (isFocused) {
            outputString += "|" + windowName + "|";
        } else {
            outputString += " " + windowName + " ";
        }
    }

    // Print the final string
    std::cout << outputString << std::endl;

    return 0;  // Exit successfully
}
