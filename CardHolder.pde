import java.util.ArrayList;

public class CardHolder{
    PVector pos;
    StackType type;
    ArrayList<Card> cards = new ArrayList();

    float cardWidth = width / 7 * 0.9;
    float cardHeight = cardWidth / 2.5 * 3.5;
    float fontSize = cardWidth * 0.3;

    public CardHolder(float x, float y, StackType stackType) {
        pos = new PVector(x, y);
        type = stackType;
    }

    public void draw() {
        fill(255);
        rect(pos.x - 10, pos.y - 10, 20, 20);

        switch (type) {
            case NUM:
                drawNum();
                break;
            default:
                break;
        }
    }

    public void drawNum() {
        fill(50, 150, 250);
        rectMode(CENTER);
        rect(pos.x, pos.y, cardWidth, cardHeight, 12);

        textAlign(CENTER, CENTER);
        textSize(fontSize);
        fill(51);
        text(cards.size(), pos.x, pos.y);
    }

    public PVector getPos() {
        return pos;
    }

    public void addCard(Card card) {
        card.setPosition(pos);
        cards.add(card);
    }

    public int getSize() {
        return cards.size();
    }
}