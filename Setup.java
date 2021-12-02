import java.util.List;
import java.util.Arrays;


public class Setup {
    public static List<String> config = Arrays.asList(
            "Manjaro",
            "i3-gaps",
            "Zsh",
            "Alacritty",
            "Picom",
            "Neovim",
            "Gruvbox"
            );
    public static void main (String[] args) {
        for (String s : config) {
            System.out.println(s);
        }
    }
}



