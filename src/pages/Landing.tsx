import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'
import { LandingHero } from '@/components/sections/Hero'
import { StatsMarquee } from '@/components/sections/StatsMarquee'
import { IntroSection } from '@/components/sections/IntroSection'
import { FeatureSections } from '@/components/sections/FeatureSections'
import { CategoryShowcase } from '@/components/sections/CategoryShowcase'
import { FinalCTA } from '@/components/sections/FinalCTA'

export function Landing() {
  return (
    <div className="min-h-screen flex flex-col">
      <Nav />
      <LandingHero />
      <StatsMarquee />
      <IntroSection />
      <FeatureSections />
      <CategoryShowcase />
      <FinalCTA />
      <Footer />
    </div>
  )
}
