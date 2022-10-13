package com.example.androidbarcode.dummy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Helper class for providing sample content for user interfaces created by
 * Android template wizards.
 * <p>
 * TODO: Replace all uses of this class before publishing your app.
 */
public class DummyContent {

    /**
     * An array of sample (dummy) items.
     */
    public static List<DummyItem> ITEMS = new ArrayList<DummyItem>();

    /**
     * A map of sample (dummy) items, by ID.
     */
    public static Map<String, DummyItem> ITEM_MAP = new HashMap<String, DummyItem>();

    static {
        // Add 3 sample items.
        addItem(new DummyItem("1", "Code 39"));
        addItem(new DummyItem("2", "Code 39 ASCII"));
        addItem(new DummyItem("3", "Code 128A"));
        addItem(new DummyItem("4", "Code 128B"));
        addItem(new DummyItem("5", "Code 128C"));
        addItem(new DummyItem("6", "Code 128Auto"));
        addItem(new DummyItem("7", "UCCEAN"));
        addItem(new DummyItem("8", "Code 93"));
        addItem(new DummyItem("9", "Codabar"));
        addItem(new DummyItem("10", "I2of5"));
        addItem(new DummyItem("11", "ITF14"));
        addItem(new DummyItem("12", "Industrial2of5"));
        addItem(new DummyItem("13", "Modified Plessy"));
        addItem(new DummyItem("14", "EAN13"));
        addItem(new DummyItem("15", "EAN13 - Embedded Human Readable"));
        addItem(new DummyItem("16", "EAN8"));
        addItem(new DummyItem("17", "EAN8 - Embedded Human Readable"));
        addItem(new DummyItem("21", "UPCA"));
        addItem(new DummyItem("22", "UPCA - Embedded Human Readable"));
        addItem(new DummyItem("23", "UPCE"));
        addItem(new DummyItem("24", "UPCE - Embedded Human Readable"));
        addItem(new DummyItem("25", "EXT2"));
        addItem(new DummyItem("26", "EXT5"));
        addItem(new DummyItem("27", "GS1 Databar 14"));                    
    }

    private static void addItem(DummyItem item) {
        ITEMS.add(item);
        ITEM_MAP.put(item.id, item);
    }

    /**
     * A dummy item representing a piece of content.
     */
    public static class DummyItem {
        public String id;
        public String content;

        public DummyItem(String id, String content) {
            this.id = id;
            this.content = content;
        }

        @Override
        public String toString() {
            return content;
        }
    }
}
