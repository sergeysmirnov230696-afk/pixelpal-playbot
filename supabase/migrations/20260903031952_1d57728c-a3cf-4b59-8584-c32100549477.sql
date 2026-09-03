CREATE TABLE public.game_settings (
  id boolean PRIMARY KEY DEFAULT true CHECK (id),
  min_deposit numeric NOT NULL DEFAULT 1,
  min_withdraw numeric NOT NULL DEFAULT 1,
  min_collect numeric NOT NULL DEFAULT 0.01,
  referral_percent numeric NOT NULL DEFAULT 15,
  referral_bonus numeric NOT NULL DEFAULT 0.02,
  updated_at timestamptz NOT NULL DEFAULT now()
);

GRANT ALL ON public.game_settings TO service_role;
ALTER TABLE public.game_settings ENABLE ROW LEVEL SECURITY;

INSERT INTO public.game_settings (id) VALUES (true);

ALTER TABLE public.transactions
  ADD COLUMN address text,
  ADD COLUMN invoice_id text,
  ADD COLUMN txid text,
  ADD COLUMN admin_note text,
  ADD COLUMN updated_at timestamptz NOT NULL DEFAULT now();

ALTER TABLE public.players
  ADD COLUMN first_dragon_at timestamptz;

ALTER TABLE public.referrals
  ADD COLUMN bonus_paid boolean NOT NULL DEFAULT false,
  ADD COLUMN invited_key text;

CREATE INDEX IF NOT EXISTS idx_transactions_status ON public.transactions (status, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_transactions_invoice ON public.transactions (invoice_id);