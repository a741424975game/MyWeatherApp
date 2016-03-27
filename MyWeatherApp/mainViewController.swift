//
//  mainViewController.swift
//  MyWeatherApp
//
//  Created by GuanZhipeng on 16/3/27.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import KGFloatingDrawer

class mainViewController: UIViewController {


    
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var tempTF: UITextField!
    
    @IBOutlet weak var windTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if NSUserDefaults.standardUserDefaults().valueForKey("defaultCity") == nil {
            NSUserDefaults.standardUserDefaults().setValue("101010100", forKey: "defaultCity")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        setWeatherInfo(weatherAPI((NSUserDefaults.standardUserDefaults().valueForKey("defaultCity")?.description)!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showWeatherForecast(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleLeftDrawer(sender, animated: true)
    }

    @IBAction func showSetting(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
        
    }
    
    func weatherAPI(cityID:String) -> NSData? {
        let url:String = "http://www.weather.com.cn/data/sk/\(cityID).html"
        let data:NSData = NSData(contentsOfURL: NSURL(string: url)!)!
        return data
    }
    
    @IBAction func refresh(sender: AnyObject) {
        setWeatherInfo(weatherAPI((NSUserDefaults.standardUserDefaults().valueForKey("defaultCity")?.description)!)!)
    }
    func setWeatherInfo(data:NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let weatherInfo = json.valueForKey("weatherinfo")
            cityTF.text = weatherInfo!.valueForKey("city")?.description
            tempTF.text = weatherInfo!.valueForKey("temp")?.description
            windTF.text = weatherInfo!.valueForKey("WD")?.description
            
            
        }catch {
        
        }
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
