import 'package:supabase_flutter/supabase_flutter.dart';

class Utils {
  static String supabaseUrl = "https://ujpelddgoozokzzdgbpv.supabase.co";
  static String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVqcGVsZGRnb296b2t6emRnYnB2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjI5Njc0NTEsImV4cCI6MTk3ODU0MzQ1MX0.T2pDnvsNT17LaJZ9M9yqs73kPjOghS1ozD9QhTvvC_c";

  static SupabaseClient supabaseClient =
      SupabaseClient(supabaseUrl, supabaseKey);
}
