public class Stock extends CardHolder {
    public Stock(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        fill(250, 50, 100);
        rectMode(CENTER);
        rect(pos.x, pos.y, cardWidth, cardHeight, 12);

        textAlign(CENTER, CENTER);
        textSize(fontSize);
        fill(51);
        text(cards.size(), pos.x, pos.y);
    }

    public Card drawCard() {
        if (cards.size() > 0) {
            return cards.remove(cards.size() - 1);
        }

        return null;
    }
}