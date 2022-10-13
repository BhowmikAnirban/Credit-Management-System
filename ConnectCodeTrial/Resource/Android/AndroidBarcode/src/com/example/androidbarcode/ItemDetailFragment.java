package com.example.androidbarcode;

import net.connectcode.*;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.androidbarcode.dummy.DummyContent;

/**
 * A fragment representing a single Item detail screen.
 * This fragment is either contained in a {@link ItemListActivity}
 * in two-pane mode (on tablets) or a {@link ItemDetailActivity}
 * on handsets.
 */
public class ItemDetailFragment extends Fragment {
    /**
     * The fragment argument representing the item ID that this fragment
     * represents.
     */
    public static final String ARG_ITEM_ID = "item_id";

    /**
     * The dummy content this fragment is presenting.
     */
    private DummyContent.DummyItem mItem;

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public ItemDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(ARG_ITEM_ID)) {
            // Load the dummy content specified by the fragment
            // arguments. In a real-world scenario, use a Loader
            // to load content from a content provider.
            mItem = DummyContent.ITEM_MAP.get(getArguments().getString(ARG_ITEM_ID));
        }

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_item_detail, container, false);

        // Show the dummy content as text in a TextView.
        if (mItem != null) {

            TextView barcodeView=((TextView) rootView.findViewById(R.id.item_detail));
        	String barcodeType=mItem.content;
        	String input="12345678";
        	String output="";
        	Typeface tf = null;
        	String humanReadableText="";
        	
        	if (barcodeType.equals("Code 39"))
        	{
        		Code39 barcode=new Code39();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode39_S3_Trial.ttf"); //or ConnectCode39_S3.ttf for registered version
	            output=barcode.encode(input, 1); //2nd Param indicates Check Digit
	            humanReadableText=barcode.getHumanText();
        	}
            else if (barcodeType == "Code 39 ASCII")
            {
        		Code39ASCII barcode=new Code39ASCII();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode39_S3_Trial.ttf");
	            output=barcode.encode(input, 1); //2nd Param indicates Check Digit	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Code 128A")
            {
        		Code128A barcode=new Code128A();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode128_S3_Trial.ttf");
	            output=barcode.encode(input);	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Code 128B")
            {
        		Code128B barcode=new Code128B();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode128_S3_Trial.ttf");
	            output=barcode.encode(input);	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Code 128C")
            {
        		Code128C barcode=new Code128C();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode128_S3_Trial.ttf");
	            output=barcode.encode(input);	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Code 128Auto")
            {
        		Code128Auto barcode=new Code128Auto();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode128_S3_Trial.ttf");
	            output=barcode.encode(input);	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "UCCEAN")
            {
                input = "(01)12345678";
        		UCCEAN barcode=new UCCEAN();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode128_S3_Trial.ttf");
	            output=barcode.encode(input);	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Code 93")
            {
        		Code93 barcode=new Code93();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode93_S3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Check Digit	                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Codabar")
            {
            	CodeCodabar barcode=new CodeCodabar();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeCodabar_S3_Trial.ttf");
                input = "A123456A";
	            output=barcode.encode(input);                                            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "I2of5")
            {
            	I2of5 barcode=new I2of5();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeI2of5_S3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Check Digit	                                           
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "ITF14")
            {
            	ITF14 barcode=new ITF14();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeITF_S3_Trial.ttf");
	            output=barcode.encode(input,1,0); 
	            //2nd Param indicates Check Digit
	            //3rd Param indicates Bearers Bar 0 - Top/Bottom or 1 - Rectangle	                                           
	            humanReadableText=barcode.getHumanText();
            }        	
            else if (barcodeType == "Industrial2of5")
            {
            	Industrial2of5 barcode=new Industrial2of5();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeIND2of5_S3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Check Digit	                                           
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "Modified Plessy")
            {
            	ModifiedPlessy barcode=new ModifiedPlessy();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeMSI_S3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Check Digit	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EAN13")
            {
            	EAN13 barcode=new EAN13();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input,0); //2nd Param indicates Embedded Human Readable	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EAN13 - Embedded Human Readable")
            {
            	EAN13 barcode=new EAN13();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Embedded Human Readable
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EAN8")
            {
            	EAN8 barcode=new EAN8();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input); //2nd Param for Embedded Human Readable not required
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EAN8 - Embedded Human Readable")
            {
            	EAN8 barcode=new EAN8();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf");
	            output=barcode.encode(input); //2nd Param for Embedded Human Readable not required
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "UPCA")
            {
            	UPCA barcode=new UPCA();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input,0); //2nd Param indicates Embedded Human Readable	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "UPCA - Embedded Human Readable")
            {
            	UPCA barcode=new UPCA();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Embedded Human Readable	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "UPCE")
            {
            	UPCE barcode=new UPCE();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input,0); //2nd Param indicates Embedded Human Readable	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "UPCE - Embedded Human Readable")
            {
            	UPCE barcode=new UPCE();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf");
	            output=barcode.encode(input,1); //2nd Param indicates Embedded Human Readable	                                           	            
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EXT2")
            {
            	EXT2 barcode=new EXT2();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input); //2nd Param for Embedded Human Readable not required
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "EXT5")
            {
            	EXT5 barcode=new EXT5();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeUPCEAN_S3_Trial.ttf");
	            output=barcode.encode(input); //2nd Param for Embedded Human Readable not required
	            humanReadableText=barcode.getHumanText();
            }
            else if (barcodeType == "GS1 Databar 14")
            {
            	GS1Databar14 barcode=new GS1Databar14();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCodeGS1D_S3_Trial.ttf");
                input = "12401234567898";
	            output=barcode.encode(input,0); //2nd Param indicates barcode linkage. leave as 0
	            humanReadableText=barcode.getHumanText();
            }
            else //default to Code 39
            {
        		Code39 barcode=new Code39();
	            tf = Typeface.createFromAsset(getActivity().getAssets(),
	                    "barcodefonts/ConnectCode39_S3_Trial.ttf"); //or ConnectCode39_S3.ttf for registered version
	            output=barcode.encode(input, 1); //2nd Param indicates Check Digit
	            humanReadableText=barcode.getHumanText();
            }

            barcodeView.setTypeface(tf);
            barcodeView.setText(output);
            barcodeView.setTextSize(32);
            
        }

        return rootView;
    }
}
