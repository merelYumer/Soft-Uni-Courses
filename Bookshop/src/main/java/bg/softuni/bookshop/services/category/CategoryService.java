package bg.softuni.bookshop.services.category;

import bg.softuni.bookshop.entities.Category;

import java.util.List;
import java.util.Set;

public interface CategoryService {
    void seedCategories(List<Category> categories);
    boolean isDataSeeded();
    Set<Category> getRandomCategories();
}
