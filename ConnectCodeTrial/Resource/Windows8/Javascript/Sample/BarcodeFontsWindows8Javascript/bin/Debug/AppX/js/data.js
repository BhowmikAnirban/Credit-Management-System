(function () {
    "use strict";

    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // TODO: Replace the data with your real data.
    // You can add data from asynchronous sources whenever it becomes available.
    generateSampleData().forEach(function (item) {
        list.push(item);
    });

    WinJS.Namespace.define("Data", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference
    });

    // Get a reference for an item, using the group key and item title as a
    // unique reference to the item that can be easily serialized.
    function getItemReference(item) {
        return [item.group.key, item.title];
    }

    // This function returns a WinJS.Binding.List containing only the items
    // that belong to the provided group.
    function getItemsFromGroup(group) {
        return list.createFiltered(function (item) { return item.group.key === group.key; });
    }

    // Get the unique group corresponding to the provided group key.
    function resolveGroupReference(key) {
        for (var i = 0; i < groupedItems.groups.length; i++) {
            if (groupedItems.groups.getAt(i).key === key) {
                return groupedItems.groups.getAt(i);
            }
        }
    }

    // Get a unique item from the provided string array, which should contain a
    // group key and an item title.
    function resolveItemReference(reference) {
        for (var i = 0; i < groupedItems.length; i++) {
            var item = groupedItems.getAt(i);
            if (item.group.key === reference[0] && item.title === reference[1]) {
                return item;
            }
        }
    }

    // Returns an array of sample data that can be added to the application's
    // data list. 
    function generateSampleData() {
        var itemContent = "<p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat</p><p>Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat";
        var itemDescription = "Item Description: Pellentesque porta mauris quis interdum vehicula urna sapien ultrices velit nec venenatis dui odio in augue cras posuere enim a cursus convallis neque turpis malesuada erat ut adipiscing neque tortor ac erat";
        var groupDescription = "Group Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tempor scelerisque lorem in vehicula. Aliquam tincidunt, lacus ut sagittis tristique, turpis massa volutpat augue, eu rutrum ligula ante a ante";

        // These three strings encode placeholder images. You will want to set the
        // backgroundImage property in your real data to be URLs to images.
        var darkGray = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXY3B0cPoPAANMAcOba1BlAAAAAElFTkSuQmCC";
        var lightGray = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXY7h4+cp/AAhpA3h+ANDKAAAAAElFTkSuQmCC";
        var mediumGray = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXY5g8dcZ/AAY/AsAlWFQ+AAAAAElFTkSuQmCC";

        // Each of these sample groups must have a unique key to be displayed
        // separately.
        var sampleGroups = [
            { key: "group1", title: "Barcodes", subtitle: "Group Subtitle: 1", backgroundImage: darkGray, description: groupDescription },
        ];

        // Each of these sample items should have a reference to a particular
        // group.
        var sampleItems = [
                    {
                        group: sampleGroups[0], title: "Code 39", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode39_S3_Trial", fontSize: "Font Size : 32", description: "Code 39 barcode is one of the earliest and most widely used barcode. It is a variable length barcode, which means that you will be able to encode any number of characters in the barcode. It supports alphanumeric characters and is used in a wide variety of applications.", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode39_S1.ttf<br />ConnectCode39_S2.ttf<br />ConnectCode39_S3.ttf<br />ConnectCode39_S4.ttf<br />ConnectCode39_S5.ttf<br />ConnectCode39_S6.ttf<br />ConnectCode39_S7.ttf<br />ConnectCode39_HS3.ttf - Embedded Human Readable Text"
                    },
                    {
                        group: sampleGroups[0], title: "Code 39 ASCII", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode39_S3_Trial", fontSize: "Font Size : 32", description: "Code 39 barcode is one of the earliest and most widely used barcode. It is a variable length barcode, which means that you will be able to encode any number of characters in the barcode. It supports alphanumeric characters and is used in a wide variety of applications.<br /><br />Although the Code 39 barcode only supports 43 characters, it is possible to employ a substitution mechanism based on industry specifications to encode all the 128 ASCII characters. The Code 39 barcode that employs this mechanism is known as the Code 39 Extended barcode or Code 39 ASCII barcode. ", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode39_S1.ttf<br />ConnectCode39_S2.ttf<br />ConnectCode39_S3.ttf<br />ConnectCode39_S4.ttf<br />ConnectCode39_S5.ttf<br />ConnectCode39_S6.ttf<br />ConnectCode39_S7.ttf<br />ConnectCode39_HS3.ttf - Embedded Human Readable Text"
                    },
                    {
                        group: sampleGroups[0], title: "Code 93", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode93_S3_Trial", fontSize: "Font Size : 32", description: "Code 93 is a high density barcode that contains two check characters called the C and K check characters. The regular Code 93 barcode supports 47 characters as below. <br /><br />Numerics '0'..'9'<br />Uppercase Alphabets 'A'..'Z'<br />Punctuations ' ','$','%','+','-','.','/'<br /><br />This barcode can also be extended using four shift characters to uniquely represent all the 128 ASCII characters. ConnectCode Code 93 barcode font/encoder supports both the basic and extended version of the barcode. ", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode93_S1.ttf<br />ConnectCode93_S2.ttf<br />ConnectCode93_S3.ttf<br />ConnectCode93_S4.ttf<br />ConnectCode93_S5.ttf<br />ConnectCode93_S6.ttf<br />ConnectCode93_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "Codabar", input: "Input : A123456A", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeCodabar_S3_Trial", fontSize: "Font Size : 32", description: "Codabar is a barcode that is commonly used in blood banks and libraries applications. It supports 16 characters and uses the characters 'A', 'B', 'C', 'D' as start and stop characters. This barcode is also sometimes called Rationalized Codabar or USS-Codabar.", content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeCodabar_S1.ttf<br />ConnectCodeCodabar_S2.ttf<br />ConnectCodeCodabar_S3.ttf<br />ConnectCodeCodabar_S4.ttf<br />ConnectCodeCodabar_S5.ttf<br />ConnectCodeCodabar_S6.ttf<br />ConnectCodeCodabar_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "Code 128A", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode128_S3_Trial", fontSize: "Font Size : 32", description: "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. <br /><br />Other than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. <br /><br />Character Set supported :<br /><br />Code128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization <br />Code128A - ASCII without lowercase characters<br />Code128B - ASCII without the initial ASCII special characters<br />Code128C - Numeric", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode128_S1.ttf<br />ConnectCode128_S2.ttf<br />ConnectCode128_S3.ttf<br />ConnectCode128_S4.ttf<br />ConnectCode128_S5.ttf<br />ConnectCode128_S6.ttf<br />ConnectCode128_S7.ttf<br />ConnectCode128B_HS3.ttf - Embedded Human Readable Text Font for Code128B"
                    },
                    {
                        group: sampleGroups[0], title: "Code 128B", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode128_S3_Trial", fontSize: "Font Size : 32", description: "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. <br /><br />Other than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. <br /><br />Character Set supported :<br /><br />Code128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization <br />Code128A - ASCII without lowercase characters<br />Code128B - ASCII without the initial ASCII special characters<br />Code128C - Numeric", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode128_S1.ttf<br />ConnectCode128_S2.ttf<br />ConnectCode128_S3.ttf<br />ConnectCode128_S4.ttf<br />ConnectCode128_S5.ttf<br />ConnectCode128_S6.ttf<br />ConnectCode128_S7.ttf<br />ConnectCode128B_HS3.ttf - Embedded Human Readable Text Font for Code128B"
                    },
                    {
                        group: sampleGroups[0], title: "Code 128C", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode128_S3_Trial", fontSize: "Font Size : 32", description: "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. <br /><br />Other than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. <br /><br />Character Set supported :<br /><br />Code128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization <br />Code128A - ASCII without lowercase characters<br />Code128B - ASCII without the initial ASCII special characters<br />Code128C - Numeric", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode128_S1.ttf<br />ConnectCode128_S2.ttf<br />ConnectCode128_S3.ttf<br />ConnectCode128_S4.ttf<br />ConnectCode128_S5.ttf<br />ConnectCode128_S6.ttf<br />ConnectCode128_S7.ttf<br />ConnectCode128B_HS3.ttf - Embedded Human Readable Text Font for Code128B"
                    },
                    {
                        group: sampleGroups[0], title: "Code 128Auto", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode128_S3_Trial", fontSize: "Font Size : 32", description: "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. <br /><br />Other than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. <br /><br />Character Set supported :<br /><br />Code128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization <br />Code128A - ASCII without lowercase characters<br />Code128B - ASCII without the initial ASCII special characters<br />Code128C - Numeric", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode128_S1.ttf<br />ConnectCode128_S2.ttf<br />ConnectCode128_S3.ttf<br />ConnectCode128_S4.ttf<br />ConnectCode128_S5.ttf<br />ConnectCode128_S6.ttf<br />ConnectCode128_S7.ttf<br />ConnectCode128B_HS3.ttf - Embedded Human Readable Text Font for Code128B"
                    },
                    {
                        group: sampleGroups[0], title: "UCCEAN/GS1-128", input: "Input : (10)12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCode128_S3_Trial", fontSize: "Font Size : 32", description: "UCC EAN is an international barcode format used widely by many different companies. It uses a list of Application Identifiers (AI) for identifying the structure and format of the data in the barcode. For example, AI 00 is used for identifying a 18 digits Serial Shipping Container Code. <br /><br />The UCC/EAN uses the Code 128 barcode font and specifically the Code 128 Auto character set. ", content: "<br />Fonts with varying height supported :<br /><br />ConnectCode128_S1.ttf<br />ConnectCode128_S2.ttf<br />ConnectCode128_S3.ttf<br />ConnectCode128_S4.ttf<br />ConnectCode128_S5.ttf<br />ConnectCode128_S6.ttf<br />ConnectCode128_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "I2of5", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeI2of5_S3_Trial", fontSize: "Font Size : 32", description: "I2of5 (Interleaved 2 of 5) is a widely used, high density barcode supporting numeric characters. The data to be encoded must contain even number of digits as each two digit numbers is uniquely represented by a set of bars and spaces in the barcode. The character '0' may be added to the beginning if the data does not contain an even number of digits.", content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeI2of5_S1.ttf<br />ConnectCodeI2of5_S2.ttf<br />ConnectCodeI2of5_S3.ttf<br />ConnectCodeI2of5_S4.ttf<br />ConnectCodeI2of5_S5.ttf<br />ConnectCodeI2of5_S6.ttf<br />ConnectCodeI2of5_S7.ttf<br />ConnectCodeI2of5_HS3.ttf - Embedded Human Readable Text"
                    },
                    {
                        group: sampleGroups[0], title: "ITF14", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeITF_S3_Trial", fontSize: "Font Size : 32", description: "The ITF14 is a 14 digits barcode used to mark the external containers of products with a EAN identifier. It is based on the I2of5 barcode. ITF14 barcodes usually contain a top and bottom bar (sometimes rectangle) called the Bearers bar. The purpose of the Bearers bar is to make sure that the barcode is read completely.", content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeITF_S1.ttf<br />ConnectCodeITF_S2.ttf<br />ConnectCodeITF_S3.ttf<br />ConnectCodeITF_S4.ttf<br />ConnectCodeITF_S5.ttf<br />ConnectCodeITF_S6.ttf<br />ConnectCodeITF_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "Industrial 2of5", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeIND2of5_S3_Trial", fontSize: "Font Size : 32", description: "The Industrial 2of5 barcode is used for encoding numbers. It is called 2of5 because the barcode is always encoded with 2 wide bars and 3 narrow bars (total of 5 bars). Each of the bars is separated by a narrow space.", content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeIND2of5_S1.ttf<br />ConnectCodeIND2of5_S2.ttf<br />ConnectCodeIND2of5_S3.ttf<br />ConnectCodeIND2of5_S4.ttf<br />ConnectCodeIND2of5_S5.ttf<br />ConnectCodeIND2of5_S6.ttf<br />ConnectCodeIND2of5_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "Modified Plessy", input: "Input : 12345678", checkDigit: "Check Digit : 1 (On)", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeMSI_S3_Trial", fontSize: "Font Size : 32", description: "The Modified Plessy (MSI) barcode is used for encoding numbers and is typically used warehouses for the control of inventory. This symbology is developed by MSI Data Corporation. ", content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeMSI_S1.ttf<br />ConnectCodeMSI_S2.ttf<br />ConnectCodeMSI_S3.ttf<br />ConnectCodeMSI_S4.ttf<br />ConnectCodeMSI_S5.ttf<br />ConnectCodeMSI_S6.ttf<br />ConnectCodeMSI_S7.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EAN13 (European Article Numbering)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EAN13 (with Embedded Human Readable Text)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 1 (On)",
                        fontName: "Font Name : ConnectCodeUPCEAN_HRBS3_Trial", fontSize: "Font Size : 32",
                        description: "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EAN8 (European Article Numbering)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "8 digits European Article Numbering barcode. It consists of 2 digits Country Code, 5 digits Product Code and 1 Check Digit.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EAN8 (with Embedded Human Readable Text)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 1 (On)",
                        fontName: "Font Name : ConnectCodeUPCEAN_HRBS3_Trial", fontSize: "Font Size : 32",
                        description: "8 digits European Article Numbering barcode. It consists of 2 digits Country Code, 5 digits Product Code and 1 Check Digit.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "UPCA (Universal Product Code)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "12 digits Universal Product Code. This barcode is used to identify each product with a unique code. It consists of a 1 digit Numbering System, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "UPCA (with Embedded Human Readable Text)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 1 (On)",
                        fontName: "Font Name : ConnectCodeUPCEAN_HRBS3_Trial", fontSize: "Font Size : 32",
                        description: "12 digits Universal Product Code. This barcode is used to identify each product with a unique code. It consists of a 1 digit Numbering System, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "UPCE (European Article Numbering)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "A 6 digits condensed version of UPCA. This barcode is typically used on items where space is a constraint.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "UPCE (with Embedded Human Readable Text)", input: "Input : 12345678", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 1 (On)",
                        fontName: "Font Name : ConnectCodeUPCEAN_HRBS3_Trial", fontSize: "Font Size : 32",
                        description: "A 6 digits condensed version of UPCA. This barcode is typically used on items where space is a constraint.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EXT2", input: "Input : 12", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "Extension 2 barcode. To indicate issue number of magazines.",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "EXT5", input: "Input : 12345", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : 0 (Off)",
                        fontName: "Font Name : ConnectCodeUPCEAN_S3_Trial", fontSize: "Font Size : 32",
                        description: "Extension 5 barcode. To indicate suggested retail price of books and magazines. Typically used with ISBN(International Standard Book Number).",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeUPCEAN_S1.ttf<br />ConnectCodeUPCEAN_S2.ttf<br />ConnectCodeUPCEAN_S3.ttf<br />ConnectCodeUPCEAN_S4.ttf<br />ConnectCodeUPCEAN_S5.ttf<br />ConnectCodeUPCEAN_S6.ttf<br />ConnectCodeUPCEAN_S7.ttf<br /><br />Fonts with Text at the Bottom the barcode :<br /><br />ConnectCodeUPCEAN_HRBS1.ttf<br />ConnectCodeUPCEAN_HRBS2.ttf<br />ConnectCodeUPCEAN_HRBS3.ttf<br />ConnectCodeUPCEAN_HRBS4.ttf<br />ConnectCodeUPCEAN_HRBS5.ttf<br />ConnectCodeUPCEAN_HRBS6.ttf<br />ConnectCodeUPCEAN_HRBS7.ttf<br /><br />Fonts with Text at the Top the barcode :<br /><br />ConnectCodeUPCEAN_HRTS1.ttf<br />ConnectCodeUPCEAN_HRTS2.ttf<br />ConnectCodeUPCEAN_HRTS3.ttf"
                    },
                    {
                        group: sampleGroups[0], title: "GS1 Databar 14", input: "Input : 12401234567898", checkDigit: "Check Digit : N.A.", humanReadable: "Embedded Human Readable Text : N.A.",
                        fontName: "Font Name : ConnectCodeGS1D_S3_Trial", fontSize: "Font Size : 32",
                        description: "The GS1 Databar is a family of barcodes based on the ISO/IEC 24724:2006 specifications to be used with the UCC/EAN system. The barcode is intended for encoding the identification numbers of items and their supplementary data. It is more compact and can carry more information than the current EAN/UPC barcode and is thus capable of identifying small items more easily. \n\nAs the EAN/UCC system is defined in a consistent manner around the world, it is extremely useful for the identification of trade items.\n\nGS1 Databar 14 (formerly Reduced Space Symbology RSS14) - Encodes the 14 digits EAN/UCC item identification. ",
                        content: "<br />Fonts with varying height supported :<br /><br />ConnectCodeGS1D_S1.ttf<br />ConnectCodeGS1D_S2.ttf<br />ConnectCodeGS1D_S3.ttf<br />ConnectCodeGS1D_S4.ttf<br />ConnectCodeGS1D_S5.ttf<br />ConnectCodeGS1D_S6.ttf<br />ConnectCodeGS1D_S7.ttf"
                    }
        ];

        return sampleItems;
    }
})();
