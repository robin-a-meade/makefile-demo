#include <stdio.h>
#include <time.h>

// Define a structure for storing person information
typedef struct {
    char name[50];
    int day;
    int month;
    int year;
} Person;

// Function to calculate age given a person's date of birth
int calculate_age(int day, int month, int year) {
    time_t t = time(NULL);
    struct tm *current_time = localtime(&t);

    int current_year = current_time->tm_year + 1900;
    int current_month = current_time->tm_mon + 1;
    int current_day = current_time->tm_mday;

    int age = current_year - year;

    if (current_month < month || (current_month == month && current_day < day)) {
        age--;
    }

    return age;
}

// Function to print person details
void print_person_details(Person p) {
    int age = calculate_age(p.day, p.month, p.year);
    printf("Name: %s, Date of Birth: %02d/%02d/%04d, Age: %d\n", p.name, p.day, p.month, p.year, age);
}

// Main function
int main() {
    // Create a database of persons
    Person database[3] = {
        {"Alice", 15, 5, 1990},
        {"Bob", 20, 8, 1985},
        {"Charlie", 10, 12, 2000}
    };

    // Print details for each person in the database
    for (int i = 0; i < 3; i++) {
        print_person_details(database[i]);
    }

    return 0;
}

