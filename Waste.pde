public class Waste extends CardHolder {
    public Waste(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        if (cards.size() > 0) {
            cards.get(cards.size() - 1).draw();
        }
    }

    @Override
    public void addCard(Card card) {
        card.setPosition(pos);
        cards.add(card);
    }
}