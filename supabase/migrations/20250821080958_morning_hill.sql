/*
  # Create donators table

  1. New Tables
    - `donators`
      - `id` (uuid, primary key)
      - `name` (text, required) - Name of the donator
      - `created_at` (timestamp) - When the donation was recorded

  2. Security
    - Enable RLS on `donators` table
    - Add policy for public read access (anyone can view donators)
    - Add policy for authenticated insert access (only authenticated users can add donators)
*/

CREATE TABLE IF NOT EXISTS public.donators (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE public.donators ENABLE ROW LEVEL SECURITY;

-- Allow anyone to read the donators list
CREATE POLICY "Anyone can view donators"
  ON public.donators
  FOR SELECT
  TO public
  USING (true);

-- Allow authenticated users to add donators
CREATE POLICY "Authenticated users can add donators"
  ON public.donators
  FOR INSERT
  TO authenticated
  WITH CHECK (true);