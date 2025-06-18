public class Waste extends CardHolder {
    public Waste(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        if (cards.size() > 0) {
            cards.get(cards.size() - 1).draw(pos.x, pos.y);
        }
    }

    @Override
    public void addCard(Card card) {
        card.setPosition(pos);
        cards.add(card);
        println("Card added to waste: " + card);
    }

    public ArrayList<Card> popAll() {
        ArrayList<Card> allCards = new ArrayList<>(cards);
        Collections.reverse(allCards);
        cards.clear();
        return allCards;
    }
}