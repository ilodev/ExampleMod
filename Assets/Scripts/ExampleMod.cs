using System;
using HarmonyLib;
using StationeersMods.Interface;

public class ExampleMod : ModBehaviour
{
    public override void OnLoaded(ContentHandler contentHandler)
    {
        UnityEngine.Debug.Log("Hello World!");
        Harmony harmony = new Harmony("ExampleMod");
        harmony.PatchAll();
    }
}