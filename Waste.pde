public class Waste extends CardHolder {
    public Waste(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        if (cards.size() > 0) {
            cards.get(cards.size() - 1).draw(pos.x, pos.y);

            if (selected) {
                highlight();
            }
        }
    }

    @Override
    public void addCard(Card card) {
        cardWidth = card.getWidth();
        cardHeight = card.getHeight();
        card.setPosition(pos);
        cards.add(card);
    }

    @Override
    public boolean isClicked(float x, float y) {
        if (cards.size() == 0) return true;
        return super.isClicked(x, y);
    }

    public ArrayList<Card> popAll() {
        ArrayList<Card> allCards = new ArrayList<>(cards);
        Collections.reverse(allCards);
        cards.clear();
        return allCards;
    }
}