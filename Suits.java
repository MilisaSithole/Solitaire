public enum Suits {
    SPADES("spade"),
    HEARTS("heart"),
    CLUBS("club"),
    DIAMONDS("diamond");

    private final String name;

    Suits(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
