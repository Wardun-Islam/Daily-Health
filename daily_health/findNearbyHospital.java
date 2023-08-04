package com.cse.nearbyhospital;

import android.Manifest;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Bundle;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;

import android.view.View;

import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;

public class MainActivity extends AppCompatActivity {
    //initialize variable
    Spinner spType;
    Button btFind;
    SupportMapFragment supportMapFragment;
    GoogleMap map;
    FusedLocationProviderClient fusedLocationProviderClient;
    double currentLat= 0 , getCurrentLat= 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);

        //Assign variable
        spType = findViewById(R.id.sp_type);
        btFind= findViewById(R.id.bt_find);
        supportMapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.google_map);

        //initialize array of place type
        String[] placeTypeList = {"hospital"};
        String[] placeNameList = {"hospital"};

        //set adapter on spinner
        spType.setAdapter(new ArrayAdapter<>( MainActivity.this
                                          , android.R.layout.simple_spinner_dropdown_item, placeNameList));

        //Initialize fused lovation provider client

        fusedLocationProviderClient= LocationServices.getFusedLocationProviderClient(this);

        //Check permission
        if(ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.ACCESS_FINE_LOCATION)== PackageManager.PERMISSION_GRANTED){
            //WHEN PERMISSION GRANTED
            //CALL MATHOD

            getCurrentLocation();
        }else{
            //When permission denied
            //Request permission
            ActivityCompat.requestPermissions(MainActivity.this
                                      ,new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, 44);
        }
        btFind.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v){
                //Get selected position of spinner
                int i= spType.getSelectedItemPosition();
                //initialize url
                String url= "https://maps.googleapis.com/maps/api/place/nearbysearch/json" + //url
                "?location="+ currentLat+ ","+ currentLong + //Location Latitude and Logitude
                "&radius=5000" + //Nearby radius
                "&types="+ placeTypeList[i]+ //place type
            }
        });

    }

    private void getCurrentLocation() {
        //Initialize task location
        Task<Location> task = fusedLocationProviderClient.getLastLocation();
        task.addOnSuccessListener(new OnSuccessListener<Location>() {
            @Override
            public void onSuccess(Location location) {
                //when success
                if(location!= null){
                    //when location is not equal to null
                    //Get current Latitude
                    currentLat= location.getLatitude();
                    //Get current Longitude
                    currentLat= location.getLatitude();
                    //sync map
                    supportMapFragment.getMapAsync(new OnMapReadyCallback() {
                        @Override
                        public void onMapReady(GoogleMap googleMap) {
                            //when map is ready
                            map= googleMap;
                            //Zoom curret location on map
                            map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                                    new LatLng(currentLat,currentLong), v:10
                            ));
                        }
                    });
                }

            }
        })
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode==44) {
            if (grantResults.length>0 && grantResults[0]== PackageManager.PERMISSION_GRANTED) {
                      //When Permission granted
                     //call method
                getCurrentLocation();
            }
        }

        }
    }
}