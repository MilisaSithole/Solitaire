import java.util.ArrayList;

public class CardHolder{
    PVector pos;
    StackType type;
    ArrayList<Card> cards = new ArrayList();

    public CardHolder(float x, float y, StackType stackType) {
        pos = new PVector(x, y);
        type = stackType;
    }

    public void draw() {
        fill(255);
        rect(pos.x - 10, pos.y - 10, 20, 20);
    }

    public PVector getPos() {
        return pos;
    }

    public void addCard(Card card) {
        cards.add(card);
    }
}