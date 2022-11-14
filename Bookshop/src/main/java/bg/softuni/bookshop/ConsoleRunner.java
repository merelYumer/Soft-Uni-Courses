package bg.softuni.bookshop;

import bg.softuni.bookshop.entities.Author;
import bg.softuni.bookshop.entities.Book;
import bg.softuni.bookshop.services.author.AuthorService;
import bg.softuni.bookshop.services.book.BookService;
import bg.softuni.bookshop.services.seed.SeedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

@Component
public class ConsoleRunner implements CommandLineRunner {
    Scanner scanner = new Scanner(System.in);

    private final SeedService seedService;
    private final BookService bookService;
    private final AuthorService authorService;

    @Autowired
    public ConsoleRunner(SeedService seedService, BookService bookService, AuthorService authorService) {
        this.seedService = seedService;
        this.bookService = bookService;
        this.authorService = authorService;
    }


    public void run(String... args) throws Exception {
        String title = scanner.nextLine();

        Book searchedBook = this.bookService.findFirstByTitle(title);
        System.out.printf("%s %s %s %.2f%n", searchedBook.getTitle(), searchedBook.getEditionType(), searchedBook.getAgeRestriction(), searchedBook.getPrice());
    }








}
